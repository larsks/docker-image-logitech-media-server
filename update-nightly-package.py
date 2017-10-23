#!/usr/bin/env python

import jinja2
import logging
import lxml.etree
import requests
import urlparse

LOG = logging.getLogger('update-nightly-package')
logging.basicConfig(level='DEBUG')

nightly_url = 'http://downloads-origin.slimdevices.com/nightly/?ver=7.9'

LOG.info('requesting url %s', nightly_url)
res = requests.get(nightly_url)
doc = lxml.etree.fromstring(res.text, lxml.etree.HTMLParser())

rel_url = doc.xpath('//a[contains(text(), "_all.deb")]')[0].get('href')
abs_url = urlparse.urljoin(nightly_url, rel_url)
LOG.info('found url %s', abs_url)

with open('Dockerfile.in') as fd:
    t = jinja2.Template(fd.read())

LOG.info('writing Dockerfile')
with open('Dockerfile', 'w') as fd:
    fd.write(t.render(url=abs_url))
