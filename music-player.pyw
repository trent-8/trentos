import os, sys, time, tkinter, random, keyboard, pygame
from tkinter import filedialog
from enum import Enum, auto

os.environ["SDL_AUDIODRIVER"] = "pipewire"
    
class State(Enum):
    Playing = auto()
    SwitchingSongs = auto()
    Paused = auto()
    SelectFolder = auto()
    Startup = auto()
    Shutdown = auto()

mp3_files = []
state = State.Startup
cache_filename = "music_player_cache.txt"
music_directory = ""
song_index = 0

def write_to_cache(contents: str):
    file = open(cache_filename, 'w')
    file.write(contents)
    file.close()

def read_cache():
    if not os.path.exists(cache_filename):
        file = open(cache_filename, 'w')
        file.write('')
        file.close()
    file = open(cache_filename, 'r')
    contents = file.read()
    file.close()
    return contents

def play_song(file_path):
    pygame.mixer.music.load(file_path)
    pygame.mixer.music.play()
    write_to_cache(file_path)

def get_mp3_files(directory):
    return [music_directory+"/"+f for f in os.listdir(directory) if f.endswith('.mp3')]

def playing():
    global state
    if not pygame.mixer.music.get_busy():
        state = State.SwitchingSongs

def switching_songs():
    global state, mp3_files, song_index
    song_index += 1
    pygame.mixer.music.pause()
    if song_index == len(mp3_files):
        song_index = 0
    random.shuffle(mp3_files)
    play_song(mp3_files[0])
    state = State.Playing

def paused():
    pass
        
def select_folder():
    global state, mp3_files, song_index, music_directory
    music_directory = filedialog.askdirectory(title="Select a folder to play from")
    while len(get_mp3_files(music_directory)) == 0:
        music_directory = filedialog.askdirectory(title="Select a folder to play from")
    mp3_files = get_mp3_files(music_directory)
    random.shuffle(mp3_files)
    play_song(mp3_files[0])
    state = State.Playing
        
def startup():
    global state, mp3_files, song_index, music_directory
    time.sleep(0.2)
    if read_cache() == '' or not os.path.exists(read_cache()):
        music_directory = filedialog.askdirectory(title="Select a folder to play from")
        while len(get_mp3_files(music_directory)) == 0:
            music_directory = filedialog.askdirectory(title="Select a folder to play from")
        mp3_files = get_mp3_files(music_directory)
        random.shuffle(mp3_files)
    else:
        last_song = read_cache()
        music_directory = "/".join(last_song.split('/')[:-1])
        mp3_files = get_mp3_files(music_directory)
        mp3_files.remove(last_song)
        random.shuffle(mp3_files)
        mp3_files.insert(0, last_song)
    play_song(mp3_files[0])
    state = State.Playing

def shutdown():
    pygame.mixer.music.pause()
    pygame.mixer.music.unload()
    pygame.mixer.quit()
    time.sleep(0.2)
    sys.exit()

def on_play_pause():
    global state
    if state == State.Playing:
        pygame.mixer.music.pause()
        state = State.Paused
    elif state == State.Paused:
        pygame.mixer.music.unpause()
        state = State.Playing

def volume_up():
    current_volume = pygame.mixer.music.get_volume()
    current_volume += 0.02
    if current_volume > 1: current_volume = 1
    pygame.mixer.music.set_volume(current_volume)

def volume_down():
    current_volume = pygame.mixer.music.get_volume()
    current_volume -= 0.02
    if current_volume < 0: current_volume = 0
    pygame.mixer.music.set_volume(current_volume)

def select_folder_hotkey():
    global state
    pygame.mixer.music.pause()
    pygame.mixer.music.unload()
    state = State.SelectFolder

def quit_player():
    global state
    state = State.Shutdown

keyboard.add_hotkey('alt+p', on_play_pause)
keyboard.add_hotkey('alt+j', volume_down)
keyboard.add_hotkey('alt+k', volume_up)
keyboard.add_hotkey('alt+c', select_folder_hotkey)
keyboard.add_hotkey('alt+q', quit_player)

stateFunctions = {
    State.Playing: playing,
    State.SwitchingSongs: switching_songs,
    State.Paused: paused,
    State.SelectFolder: select_folder,
    State.Startup: startup,
    State.Shutdown: shutdown
}

tkinter.Tk().withdraw() # must have this if you want to be able to open the tkinter filedialog more than once

# Initialize Pygame mixer
pygame.mixer.init()
pygame.mixer.music.set_volume(0.5)

while True:
    print(state)
    stateFunctions[state]()
    time.sleep(0.05)
