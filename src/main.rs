use std::{io, io::Read, str::FromStr};

fn main() -> Result<(), Box<std::error::Error + 'static>> {
    let mut input = String::new();
    io::stdin().read_to_string(&mut input)?;
    let mut lines = input.split('\n').map(str::trim);

    match (lines.next(), lines.next()) {
        (Some(first), Some(second)) => {
            let mb_per_month: usize = first.parse()?;
            let num_months: usize = second.parse()?;
            let mut total_used = 0;
            for mb_used in lines.take(num_months).map(usize::from_str) {
                total_used += mb_used?;
            }
            let mb_left = (num_months + 1) * mb_per_month - total_used;
            println!("{}", mb_left);
        }
        _ => panic!("exhausted"),
    };
    Ok(())
}
