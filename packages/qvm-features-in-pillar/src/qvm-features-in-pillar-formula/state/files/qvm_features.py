#!/usr/bin/python2
# -*- coding: utf-8 -*-
#
# The Qubes OS Project, http://www.qubes-os.org
# Modified by Brian C. Duggan, https://gist.github.com/bcduggan
# Modified by Gonzalo Bulnes Guilpain <gon.bulnes@fastmail.com>
#
# Copyright (C) 2016  Marek Marczykowski-Górecki
#                                   <marmarek@invisiblethingslab.com>
# Copyright (C) 2019 Brian C. Duggan
# Copyright (C) 2023 Gonzalo Bulnes Guilpain
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
# USA.

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
