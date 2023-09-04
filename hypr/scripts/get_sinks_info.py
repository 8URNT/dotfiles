import pydbus

bus = pydbus.SystemBus()
pw_core = bus.get("org.freedesktop.PipeWire")

# Get the list of sink objects
sink_paths = pw_core.SpaList("Spa:Device:1", "", 0)
for path in sink_paths:
    sink = bus.get("org.freedesktop.PipeWire", path)
    name = sink.props.name
    volume = sink.props.volume
    print(f"Sink: {name}, Volume: {volume}")
