# **PROJECT MOVED**
This project orignally hosted on https://github.com/tukl-msd/median.demonstrator has now moved an is no longer maintained in this location.
Please go to https://gitlab.rhrk.uni-kl.de/EIT/ZynqVision/eit.zynqvision.main for the latest version.

# Median filter demonstrator on ZynqBerry

Please read this carefully before you clone this repository to save time and disk space.

## Environment

You need to choose between different environments dependent on the task you need to perform. How to setup these environments is described
on page _Environment_ inside the repository wiki.

|                                         | CentOS             | Debian             | Working Vivado on any system | Zynqberry (ssh)    |
|-----------------------------------------|--------------------|--------------------|------------------------------|--------------------|
| Change initial bitstream                | :white_check_mark: |                    |      :white_check_mark:      |                    |
| Change FSBL                             | :white_check_mark: |                    |      :white_check_mark:      |                    |
| Change boot.bin                         | :white_check_mark: |                    |      :white_check_mark:      |                    |
| Change u-boot                           | :white_check_mark: |                    |                              |                    |
| Change kernel                           | :white_check_mark: |                    |                              |                    |
| Change devicetree                       | :white_check_mark: |                    |                              |                    |
| Change file system                      |                    |                    |                              | :white_check_mark: |
| Regenerate file system                  |                    | :white_check_mark: |                              |                    |
| Change web front end                    |                    |                    |                              | :white_check_mark: |
| Create new median filter test bitstream |                    |                    |      :white_check_mark:      |                    |

## How to clone

If you need to change the kernel, u-boot or device tree, you need to clone this repository with the option `--recursive`

    git clone --recursive <git-repo>

otherwise you don't need the submodules linux-xlnx, u-boot-xlnx. So you can save around 3 GB of disk space .

    git clone <git-repo>
