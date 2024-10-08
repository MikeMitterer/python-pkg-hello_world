#!/usr/bin/env python
# -*- coding: utf-8 -*-pip

"""
test_hello_world
----------------------------------

Tests for `hello_world` module.
"""

import unittest

import hello_world.cli


class TestHelloWorld(unittest.TestCase):

    def setUp(self):
        self.hello_message = "Hello, World! v2"

    def test_prints_hello_world(self):
        output = hello_world.cli.hello()
        print(output, self.hello_message)

        assert output == self.hello_message

