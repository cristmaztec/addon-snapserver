#!/usr/bin/env bashio

mkdir -p /share/snapfifo
mkdir -p /share/snapcast

config=/etc/snapserver.conf

bashio::log.info "Generating snapserver.conf..."

cat > "${config}" <<EOF
[stream]
EOF

# Streams
streams=$(bashio::config 'streams')
echo "${streams}" >> "${config}"

# Stream bis
if bashio::config.has_value 'stream_bis'; then
    stream_bis=$(bashio::config 'stream_bis')
    echo "${stream_bis}" >> "${config}"
fi

# Stream ter
if bashio::config.has_value 'stream_ter'; then
    stream_ter=$(bashio::config 'stream_ter')
    echo "${stream_ter}" >> "${config}"
fi

# Buffer
buffer=$(bashio::config 'buffer')
echo "buffer = ${buffer}" >> "${config}"

# Codec
codec=$(bashio::config 'codec')
echo "codec = ${codec}" >> "${config}"

# Send to muted
muted=$(bashio::config 'send_to_muted')
echo "send_to_muted = ${muted}" >> "${config}"

# Sample format
sampleformat=$(bashio::config 'sampleformat')
echo "sampleformat = ${sampleformat}" >> "${config}"

# HTTP
http=$(bashio::config 'http_enabled')

cat >> "${config}" <<EOF

[http]
enabled = ${http}
bind_to_address = ::
doc_root = $(bashio::config 'server_datadir')
EOF

# TCP
tcp=$(bashio::config 'tcp_enabled')

cat >> "${config}" <<EOF

[tcp]
enabled = ${tcp}
EOF

# Logging
logging=$(bashio::config 'logging_enabled')

cat >> "${config}" <<EOF

[logging]
debug = ${logging}
EOF

# Server
threads=$(bashio::config 'server_threads')

cat >> "${config}" <<EOF

[server]
threads = ${threads}
EOF

# Streaming client
initial_volume=$(bashio::config 'initial_volume')

cat >> "${config}" <<EOF

[streaming_client]
initial_volume = ${initial_volume}
EOF


bashio::log.info "Starting Snapserver..."

exec snapserver -c "${config}"
