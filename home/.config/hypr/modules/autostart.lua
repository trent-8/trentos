-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
  hl.exec_cmd("dunst &")
  hl.exec_cmd("nm-applet")
  hl.exec_cmd("quickshell -p ~/.config/quickshell/trentos")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("sleep 1 && megasync")
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
  hl.exec_cmd("/usr/bin/kdeconnectd")
  hl.exec_cmd("thunar --daemon")
  hl.exec_cmd("~/llama.cpp/build/bin/llama-server --model ~/.hermes/models/Qwen3.5-9B-The-Defiant-Fable-Uncnr-Heretic-NEO-MAX-MTP-Q4_K_M.gguf --alias Qwen3.5-9B-The-Defiant-Fable-Uncnr-Heretic-NEO-MAX-MTP-Q4_K_M --host 127.0.0.1 --port 18080 --ctx-size 65536 --parallel 1 --gpu-layers all --flash-attn on --cache-type-k q4_0 --cache-type-v q4_0")
end)
