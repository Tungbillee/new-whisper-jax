import jax


def check_tpu():
    devices = jax.devices()
    tpu_devices = [device for device in devices if device.platform == 'tpu']
    if tpu_devices:
        print(f"TPU devices found: {len(tpu_devices)}")
        for device in tpu_devices:
            print(device)
    else:
        print("No TPU devices found")


if __name__ == "__main__":
    check_tpu()
