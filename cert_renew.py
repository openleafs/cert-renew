import os
import re
import subprocess
from datetime import datetime, timedelta, date
import logging


script_path = os.path.realpath(__file__)
renew_path = os.path.dirname(script_path)

logging.basicConfig(
	format='%(levelname)s - %(asctime)s - %(message)s',
	datefmt='%Y-%m-%d %H:%M:%S',
	filename=f'{renew_path}/renew.log',
	level=logging.DEBUG
)

if __name__ == '__main__':
  try:
    with open(f'{renew_path}/info.log', 'r') as reader:
      expired_date = re.findall(r'([0-9]{4}-[0-9]{2}-[0-9]{2})', reader.read())

      if len(expired_date) != 0:
        date_diff = datetime.strptime(expired_date[0], '%Y-%m-%d').date() - date.today()
      else:
        logging.error(f'expired_date: {expired_date} is empty')

      if date_diff <= timedelta(days=7):
        p = subprocess.call(['bash', f'{renew_path}/cert_renew.sh'])
        logging.info('certificate is updated')
      else:
        logging.warning('certificate is not due')
  except Exception as e:
    logging.error(e)

