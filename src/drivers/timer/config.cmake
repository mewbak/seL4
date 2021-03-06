#
# Copyright 2019, Data61
# Commonwealth Scientific and Industrial Research Organisation (CSIRO)
# ABN 41 687 119 230.
#
# This software may be distributed and modified according to the terms of
# the GNU General Public License version 2. Note that NO WARRANTY is provided.
# See "LICENSE_GPLv2.txt" for details.
#
# @TAG(DATA61_GPL)
#

cmake_minimum_required(VERSION 3.7.2)

register_driver(
    compatibility_strings "ti,am335x-timer"
    PREFIX src/drivers/timer
    CFILES "am335x-timer.c"
)
register_driver(
    compatibility_strings "qcom,kpss-timer"
    PREFIX src/drivers/timer
    CFILES "kpss-timer.c"
)
register_driver(
    compatibility_strings "samsung,exynos4210-mct"
    PREFIX src/drivers/timer
    CFILES "exynos4210-mct.c"
)
register_driver(
    compatibility_strings "samsung,exynos4412-mct"
    PREFIX src/drivers/timer
    CFILES "exynos4412-mct.c"
)
register_driver(
    compatibility_strings "fsl,imx31-epit"
    PREFIX src/drivers/timer
    CFILES "imx31-epit.c"
)
register_driver(compatibility_strings "fsl,imx31-gpt" PREFIX src/drivers/timer CFILES "imx31-gpt.c")
register_driver(
    compatibility_strings "ti,omap3430-timer"
    PREFIX src/drivers/timer
    CFILES "omap3430-timer.c"
)
register_driver(
    compatibility_strings "arm,cortex-a9-twd-timer"
    PREFIX src/drivers/timer
    CFILES "priv_timer.c"
)
register_driver(
    compatibility_strings "arm,cortex-a9-global-timer"
    PREFIX src/drivers/timer
    CFILES "global_timer.c"
)
register_driver(
    compatibility_strings "arm,armv7-timer"
    PREFIX src/drivers/timer
    CFILES "generic_timer.c"
)
register_driver(
    compatibility_strings "arm,armv8-timer"
    PREFIX src/drivers/timer
    CFILES "generic_timer.c"
)
register_driver(
    compatibility_strings "allwinner,sun4i-a10-timer"
    PREFIX src/drivers/timer
    CFILES "allwinner-timer.c"
)

set(KernelArmHaveGenericTimer OFF)

foreach(match_string IN ITEMS "arm,armv7-timer" "arm,armv8-timer")
    if(${match_string} IN_LIST compatibility_strings)
        set(KernelArmHaveGenericTimer ON)
        break()
    endif()
endforeach()

config_option(
    KernelArmExportPCNTUser EXPORT_PCNT_USER "PL0 access to generic timer CNTPCT and CNTFRQ. \
    Grant user access to physical counter and counter \
    frequency registers of the generic timer. \
    WARNING: selecting this option opens a timing \
    channel"
    DEFAULT OFF
    DEPENDS "KernelArmHaveGenericTimer"
)

config_option(
    KernelArmExportVCNTUser EXPORT_VCNT_USER "PL0 access to generic timer CNTVCT and CNTFRQ. \
    Grant user access to virtual counter and counter \
    frequency registers of the generic timer. \
    WARNING: selecting this option opens a timing \
    channel"
    DEFAULT OFF
    DEPENDS "KernelArmHaveGenericTimer"
)

config_option(
    KernelArmExportPTMRUser EXPORT_PTMR_USER "PL0 access to generic timer CNTP_CTL and CNTP_CVAL. \
    Grant user access to physical timer registers of the generic timer. \
    WARNING: selecting this option opens a storage channel and allows threads to easily \
    corrupt these registers for each other, this should only be used for \
    debugging / development purposes"
    DEFAULT OFF
    DEPENDS "KernelArmHaveGenericTimer"
)

config_option(
    KernelArmExportVTMRUser EXPORT_VTMR_USER "PL0 access to generic timer CNTV_CTL and CNTV_CVAL. \
    Grant user access to virtual timer registers of the generic timer. \
    WARNING: selecting this option opens a storage channel and allows threads to easily \
    corrupt these registers for each other, this should only be used for \
    debugging / development purposes"
    DEFAULT OFF
    DEPENDS "KernelArmHaveGenericTimer"
)
