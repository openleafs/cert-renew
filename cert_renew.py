"""Certificate Renewal Script"""

import logging
import os
import re
import subprocess
from datetime import date, datetime, timedelta

script_path = os.path.realpath(__file__)
renew_path = os.path.dirname(script_path)

logging.basicConfig(
    format="%(levelname)s - %(asctime)s - %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S",
    filename=f"{renew_path}/renew.log",
    level=logging.DEBUG,
)

if __name__ == "__main__":
    try:
        with open(f"{renew_path}/info.log", "r", encoding="utf-8") as reader:
            content = reader.read()
            expired_dates = re.findall(r"([0-9]{4}-[0-9]{2}-[0-9]{2})", content)

            if not expired_dates:
                logging.error("No expiration date found in certbot output")
            else:
                exp_date = datetime.strptime(expired_dates[0], "%Y-%m-%d").date()
                date_diff = exp_date - date.today()

                if date_diff <= timedelta(days=7):
                    # Run the renewal script and raise on failure
                    subprocess.run([f"{renew_path}/cert_renew.sh"], check=True)
                    logging.info("certificate is updated")
                else:
                    logging.warning("certificate is not due")
    except Exception as e:
        logging.error(e)
