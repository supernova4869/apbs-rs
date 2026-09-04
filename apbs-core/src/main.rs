// APBS - Adaptive Poisson-Boltzmann Solver
// Port of src/main.c

mod routines;

use std::env;
use std::collections::HashMap;
use std::path::PathBuf;
use std::process;

fn main() {
    let args: Vec<String> = env::args().collect();
    let cli = match CliArgs::parse(&args) {
        Ok(cli) => cli,
        Err(message) => {
            eprintln!("APBS error: {}", message);
            print_usage();
            process::exit(2);
        }
    };

    if cli.help {
        print_usage();
        process::exit(0);
    }
    if cli.version {
        print_version();
        process::exit(0);
    }
    if cli.print_config_template {
        print!("{}", CONFIG_TEMPLATE);
        process::exit(0);
    }
    if let Some(path) = cli.generate_config_path.as_ref() {
        if let Err(err) = std::fs::write(path, CONFIG_TEMPLATE) {
            eprintln!("APBS error: failed to write config template '{}': {}", path.display(), err);
            process::exit(1);
        }
        println!("Wrote APBS Rust config template: {}", path.display());
        process::exit(0);
    }

    let Some(input_file) = cli.input_file.as_deref() else {
        eprintln!("Usage: apbs <inputfile.in>");
        eprintln!("  or:  apbs -h/--help for help");
        process::exit(1);
    };

    let mut config = RuntimeConfig::load(cli.config_path.clone());
    configure_parallelism(&mut config);
    config.print();

    // Parse and execute
    match routines::run_apbs(input_file) {
        Ok(_) => {
            // Success
        }
        Err(e) => {
            eprintln!("APBS error: {}", e);
            process::exit(1);
        }
    }
}

#[derive(Default)]
struct CliArgs {
    input_file: Option<String>,
    config_path: Option<PathBuf>,
    generate_config_path: Option<PathBuf>,
    print_config_template: bool,
    help: bool,
    version: bool,
}

impl CliArgs {
    fn parse(args: &[String]) -> Result<Self, String> {
        let mut parsed = Self::default();
        let mut i = 1;
        while i < args.len() {
            match args[i].as_str() {
                "-h" | "--help" => {
                    parsed.help = true;
                    i += 1;
                }
                "-v" | "--version" => {
                    parsed.version = true;
                    i += 1;
                }
                "-c" | "--config" => {
                    let Some(path) = args.get(i + 1) else {
                        return Err(format!("{} requires a file path", args[i]));
                    };
                    parsed.config_path = Some(PathBuf::from(path));
                    i += 2;
                }
                "--generate-config" => {
                    let path = args
                        .get(i + 1)
                        .filter(|next| !next.starts_with('-'))
                        .map(PathBuf::from)
                        .unwrap_or_else(|| PathBuf::from(CONFIG_FILE_NAME));
                    parsed.generate_config_path = Some(path);
                    i += if args.get(i + 1).is_some_and(|next| !next.starts_with('-')) { 2 } else { 1 };
                }
                "--print-config-template" => {
                    parsed.print_config_template = true;
                    i += 1;
                }
                value if value.starts_with('-') => {
                    return Err(format!("unknown option '{}'", value));
                }
                value => {
                    if parsed.input_file.is_some() {
                        return Err(format!("multiple input files specified: '{}' and '{}'", parsed.input_file.as_deref().unwrap_or(""), value));
                    }
                    parsed.input_file = Some(value.to_string());
                    i += 1;
                }
            }
        }
        Ok(parsed)
    }
}

#[derive(Clone, Copy)]
struct ConfigEntry {
    key: &'static str,
    default: Option<&'static str>,
    presence_bool: bool,
}

struct ConfigValue {
    value: String,
    source: String,
}

struct RuntimeConfig {
    path: Option<PathBuf>,
    values: Vec<ConfigValue>,
}

const CONFIG_FILE_NAME: &str = "apbs-rust.conf";

const CONFIG_TEMPLATE: &str = include_str!("../../apbs-rust.conf");

const CONFIG_ENTRIES: &[ConfigEntry] = &[
    ConfigEntry { key: "APBS_RUST_DEBUG", default: Some("0"), presence_bool: true },
    ConfigEntry { key: "APBS_RUST_RAYON_THREADS", default: Some("0"), presence_bool: false },
    ConfigEntry { key: "RAYON_NUM_THREADS", default: Some("0"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_PARALLEL_BLOCKS", default: Some("0"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_BLOCK_THREADS", default: Some("2"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_NEWTON_ITMAX", default: Some("20"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_OVERRIDE_ITMAX", default: None, presence_bool: false },
    ConfigEntry { key: "APBS_RUST_OVERRIDE_ERRTOL", default: None, presence_bool: false },
    ConfigEntry { key: "APBS_RUST_NONLIN_SOLVER", default: Some("newton"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_PC_MODE", default: Some("op7"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_FORCE_MGSOLV", default: None, presence_bool: false },
    ConfigEntry { key: "APBS_RUST_RESTRICT_MODE", default: Some("inject"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_FORCE_MGCOAR", default: None, presence_bool: false },
    ConfigEntry { key: "APBS_RUST_APPLY_POST_DIRICHLET", default: Some("1"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_QM_UCAP", default: Some("5.0"), presence_bool: false },
    ConfigEntry { key: "APBS_RUST_FORCE_ALPHA1", default: Some("0"), presence_bool: false },
];

impl RuntimeConfig {
    fn load(cli_config_path: Option<PathBuf>) -> Self {
        let (path, file_values) = load_config_file(cli_config_path);
        let mut values = Vec::with_capacity(CONFIG_ENTRIES.len());

        for entry in CONFIG_ENTRIES {
            let existing = env::var(entry.key).ok();
            let configured = file_values.get(entry.key).cloned();
            let (value, source) = match (existing, configured, entry.default) {
                (Some(value), _, _) => (value, "env".to_string()),
                (None, Some(value), _) => (value, config_source_label(path.as_ref())),
                (None, None, Some(default)) => (default.to_string(), "default".to_string()),
                (None, None, None) => (String::new(), "unset".to_string()),
            };

            apply_config_value(entry, &value, &source);
            values.push(ConfigValue {
                value: display_config_value(entry, &value, &source),
                source,
            });
        }

        Self { path, values }
    }

    fn refresh(&mut self, key: &str) {
        if let Some((idx, entry)) = CONFIG_ENTRIES
            .iter()
            .enumerate()
            .find(|(_, entry)| entry.key == key)
        {
            let value = env::var(entry.key).unwrap_or_default();
            self.values[idx] = ConfigValue {
                value: display_config_value(entry, &value, "runtime"),
                source: "runtime".to_string(),
            };
        }
    }

    fn print(&self) {
        println!("APBS Rust runtime configuration:");
        match &self.path {
            Some(path) => println!("  config_file = {}", path.display()),
            None => println!("  config_file = <not found; using defaults/env>"),
        }
        for (entry, value) in CONFIG_ENTRIES.iter().zip(&self.values) {
            println!("  {} = {} [{}]", entry.key, value.value, value.source);
        }
    }
}

fn configure_parallelism(config: &mut RuntimeConfig) {
    let explicit_rayon = env::var("RAYON_NUM_THREADS")
        .ok()
        .and_then(|value| value.parse::<usize>().ok())
        .filter(|&value| value > 0);
    if explicit_rayon.is_some() {
        config.refresh("RAYON_NUM_THREADS");
        return;
    }

    let threads = env::var("APBS_RUST_RAYON_THREADS")
        .ok()
        .and_then(|value| value.parse::<usize>().ok())
        .filter(|&value| value > 0)
        // When a configuration file does not pin a thread count, follow the
        // OpenMP setting that the reference APBS binary honors so the two
        // solvers are benchmarked with the same concurrency.
        .or_else(|| {
            env::var("OMP_NUM_THREADS")
                .ok()
                .and_then(|value| value.parse::<usize>().ok())
                .filter(|&value| value > 0)
        })
        .unwrap_or_else(|| {
            std::thread::available_parallelism()
                .map(usize::from)
                .unwrap_or(1)
        });

    env::set_var("RAYON_NUM_THREADS", threads.to_string());
    config.refresh("RAYON_NUM_THREADS");
}

fn load_config_file(cli_config_path: Option<PathBuf>) -> (Option<PathBuf>, HashMap<String, String>) {
    let Some(path) = find_config_file(cli_config_path) else {
        return (None, HashMap::new());
    };
    let content = match std::fs::read_to_string(&path) {
        Ok(content) => content,
        Err(err) => {
            eprintln!("Warning: failed to read config '{}': {}", path.display(), err);
            return (Some(path), HashMap::new());
        }
    };

    let mut values = HashMap::new();
    for (line_no, raw_line) in content.lines().enumerate() {
        let line = raw_line.split('#').next().unwrap_or("").trim();
        if line.is_empty() {
            continue;
        }
        let Some((key, value)) = line.split_once('=') else {
            eprintln!(
                "Warning: ignoring malformed config line {} in {}",
                line_no + 1,
                path.display()
            );
            continue;
        };
        values.insert(key.trim().to_string(), trim_config_value(value.trim()));
    }
    (Some(path), values)
}

fn find_config_file(cli_config_path: Option<PathBuf>) -> Option<PathBuf> {
    if let Some(path) = cli_config_path {
        return path.is_file().then_some(path);
    }

    if let Some(path) = env::var_os("APBS_RUST_CONFIG").map(PathBuf::from) {
        return path.is_file().then_some(path);
    }

    if let Ok(exe) = env::current_exe() {
        if let Some(dir) = exe.parent() {
            let path = dir.join(CONFIG_FILE_NAME);
            if path.is_file() {
                return Some(path);
            }
        }
    }

    let cwd_path = PathBuf::from(CONFIG_FILE_NAME);
    cwd_path.is_file().then_some(cwd_path)
}

fn trim_config_value(value: &str) -> String {
    let value = value.trim();
    if value.len() >= 2 {
        let bytes = value.as_bytes();
        if (bytes[0] == b'"' && bytes[value.len() - 1] == b'"')
            || (bytes[0] == b'\'' && bytes[value.len() - 1] == b'\'')
        {
            return value[1..value.len() - 1].to_string();
        }
    }
    value.to_string()
}

fn config_source_label(path: Option<&PathBuf>) -> String {
    path.map(|p| format!("config:{}", p.display()))
        .unwrap_or_else(|| "config".to_string())
}

fn apply_config_value(entry: &ConfigEntry, value: &str, source: &str) {
    if source == "unset" {
        env::remove_var(entry.key);
        return;
    }
    if entry.presence_bool {
        if is_truthy(value) {
            env::set_var(entry.key, "1");
        } else {
            env::remove_var(entry.key);
        }
        return;
    }
    if value.is_empty() {
        env::remove_var(entry.key);
    } else {
        env::set_var(entry.key, value);
    }
}

fn display_config_value(entry: &ConfigEntry, value: &str, source: &str) -> String {
    if source == "unset" || value.is_empty() {
        return "<unset>".to_string();
    }
    if entry.presence_bool {
        if is_truthy(value) {
            "1".to_string()
        } else {
            "0".to_string()
        }
    } else {
        value.to_string()
    }
}

fn is_truthy(value: &str) -> bool {
    matches!(
        value.trim().to_ascii_lowercase().as_str(),
        "1" | "true" | "yes" | "on"
    )
}

fn print_usage() {
    println!("APBS - Adaptive Poisson-Boltzmann Solver v3.4.1");
    println!();
    println!("Usage:");
    println!("  apbs [-c FILE] <inputfile.in>");
    println!("  apbs --generate-config [FILE]");
    println!("  apbs --print-config-template");
    println!();
    println!("Options:");
    println!("  -c, --config FILE          Use the specified runtime config file");
    println!("  --generate-config [FILE]   Write a bilingual config template to FILE or ./apbs-rust.conf");
    println!("  --print-config-template    Print the bilingual config template to stdout");
    println!("  -h, --help                 Show this help message");
    println!("  -v, --version              Show version information");
    println!();
    println!("Input file format: see APBS documentation at https://apbs.readthedocs.io");
}

fn print_version() {
    println!("APBS Rust {}", env!("CARGO_PKG_VERSION"));
}
