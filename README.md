# Embetrix Buildroot external

```
git clone --recursive https://github.com/embetrix/buildroot-embetrix-external.git
```

## Configure

### For qemux86-64 target:

```
make qemux86-64_defconfig
make menuconfig
make BR2_DEFCONFIG=$PWD/configs/qemux86-64_defconfig savedefconfig
```

### For stm32mp157f-dk2 target:

```
make stm32mp157f_dk2_defconfig
make menuconfig
make BR2_DEFCONFIG=$PWD/configs/stm32mp157f_dk2_defconfig savedefconfig
```

## Build Image

```
make
```

## Generate SDK

```
make sdk
```

## Run in Qemu Emulator

```
qemu-system-x86_64 -kernel output/images/bzImage -hda output/images/rootfs.ext2  -append "root=/dev/sda rw console=ttyS0" --enable-kvm --nographic
```
