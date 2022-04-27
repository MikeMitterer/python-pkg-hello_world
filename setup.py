#!/usr/bin/env python
# -*- coding: utf-8 -*-

from codecs import open
from os import path
from setuptools import setup, find_packages
import version

here = path.abspath(path.dirname(__file__))

with open(path.join(here, 'README.md'), encoding='utf-8') as readme_file:
    readme = readme_file.read()

with open(path.join(here, 'HISTORY.rst'), encoding='utf-8') as history_file:
    history = history_file.read().replace('.. :changelog:', '')

requirements = [
    # TODO: put package requirements here
    'click',
]

test_requirements = [
    # TODO: put package test requirements here
]

# extra_requirements = [
#     # TODO: put package extra_requirements here
# ]

with open("README.md", "r") as fh:
    long_description = fh.read()

# Weitere Infos zu den folgenden Settings:
#   https://docs.python.org/3.9/distutils/apiref.html
#
setup(
    name='Hello-World-Package',
    version=version.get_git_version(),

    description="Hello World test package",
    long_description=long_description,
    long_description_content_type="text/markdown",

    author="Mike Mitterer / Sarah Riedmann",
    author_email='office@MangoLila.at',
    url='https://github.com/MikeMitterer/python-pkg-hello_world',

    packages=find_packages(exclude=['contrib', 'docs', 'tests']),

    entry_points={
        'console_scripts': [
            'hello-world=hello_world.cli:say_hello',
            ],
        },
    include_package_data=True,
    install_requires=requirements,

    license="UNLICENSED",
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Natural Language :: English',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.9',
    ],
    test_suite='tests',
    tests_require=test_requirements,
    # extra_requirements=extra_requirements,
)
