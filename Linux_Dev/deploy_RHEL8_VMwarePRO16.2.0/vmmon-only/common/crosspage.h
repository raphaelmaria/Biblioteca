/*********************************************************
 * Copyright (C) 2020 VMware, Inc. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation version 2 and no later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
 * for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
 *
 *********************************************************/

#ifndef _CROSSPAGE_H_
#define _CROSSPAGE_H_

#ifdef __cplusplus
extern "C" {
#endif

struct VMCrossPageData;

extern void HostToVmm(struct VMCrossPageData *crosspageWIN, void *unused1,
                      void *unused2, struct VMCrossPageData *crosspageSYSV);
extern const VMCrossPageData cpDataTemplate;

extern void SwitchDBHandler(void);
extern void SwitchUDHandler(void);
extern void SwitchNMIHandler(void);
extern void SwitchMCEHandler(void);
extern void CrossPage_CodePage(void);
extern void CrossPage_CodeEnd(void);

#ifdef __cplusplus
}
#endif

#endif
