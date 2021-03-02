qubes-mgmt-salt-user-split-gpg
==============================

Packaging instructions for the **qubes-mgmt-salt-user-split-gpg** RPM package.

Looking for the source files? See [`src/`][src].

  [src]: ./src/

Overview
--------

This directory contains the tools necessary to package [split-SSH][src].

Because _dom0_ is the most trusted domain and files should not be copied from less-trusted domains, copying files to _dom0_ requires special caution.

Taking advantage of [dom0's secure update mechanism][secure-updates] is one way to install files in _dom0_ that seems _reasonable_ to me; provided you trust the files you're installing! I wrote them, I sign them, I trust them. This code should allow you to _review them_, _sign them_ and _trust them_ yourself.

  [secure-updates]: https://www.qubes-os.org/doc/dom0-secure-updates

Usage
-----

These tools are a proof-of-concept. They can be used (I use them), but their usability could be improved.

I only have [rough instructions][testing-plan] to offer for the time being. If you have thoughts, ideas, or questions and want to [contribute][contributing], please do!

  [testing-plan]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/pull/3#issuecomment-778722564
  [contributing]: https://github.com/gonzalo-bulnes/qubes-mgmt-salt-user/blob/main/CONTRIBUTING.md

