#!/usr/bin/python2
# -*- coding: utf-8 -*-

# Copyright (C) 2016 Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
# Copyright (C) 2019 Brian C. Duggan <https://gist.github.com/bcduggan>
# Copyright (C) 2023 Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
#
# SPDX-License-Identifier: GPL-2.0-or-later

admin_available = True
try:
    import qubesadmin
    import qubesadmin.vm
except ImportError:
    admin_available = False


def __virtual__():
    return admin_available


def ext_pillar(minion_id, pillar, *args, **kwargs):
    app = qubesadmin.Qubes()
    try:
        vm = app.domains[minion_id]
    except KeyError:
        return {}

    return {'qubes': { 'features': dict(vm.features) } }
