import urllib.parse

import certifi  # noqa
import click
import netifaces
import requests


@click.command()
@click.argument('hostname')
@click.option('--token', prompt=True, hide_input=True)
@click.option('--interface', default='eth0')
def main(hostname, token, interface):
    addresses = netifaces.ifaddresses(interface)
    ipv6 = addresses[netifaces.AF_INET6][0]['addr']
    parameters = {'hostname': hostname, 'token': token, 'ipv6': ipv6,
                  'ipv4': 'auto'}
    response = requests.get('https://dynv6.com/api/update?{}'.format(
        urllib.parse.urlencode(parameters)))
    assert response.status_code == 200, response.content


if __name__ == '__main__':
    main()
