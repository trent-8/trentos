import os, sys, time, tkinter, random, pygame, pickle
from tkinter import filedialog
from enum import Enum, auto
from pynput import keyboard

music_directory = ""
mp3_files = []
current_index = 0
cache_file = ".playercache"
is_playing = True
alt_pressed = False

def save_state():
    with open(cache_file, 'wb') as f:
        pickle.dump(music_directory, f)

def play_current_song():
    if current_index == 0: random.shuffle(mp3_files)
    pygame.mixer.music.pause()
    pygame.mixer.music.unload()
    pygame.mixer.music.load(os.path.join(music_directory, mp3_files[current_index]))
    pygame.mixer.music.play()
    save_state()

def get_mp3_files(directory):
    return [f for f in os.listdir(directory) if f.endswith('.mp3')]

def switch_songs():
    global music_directory, current_index, mp3_files
    current_index += 1
    if current_index > len(mp3_files):
        current_index = 0
    play_current_song()
        
def select_folder():
    global music_directory, current_index, mp3_files
    music_directory = filedialog.askdirectory(title="Select a folder to play from")
    while len(get_mp3_files(music_directory)) == 0:
        music_directory = filedialog.askdirectory(title="Select a folder to play from")
    mp3_files = get_mp3_files(music_directory)
    current_index = 0

def play_pause():
    global is_playing
    if is_playing:
        pygame.mixer.music.pause()
    else:
        pygame.mixer.music.unpause()
    is_playing = not is_playing

def volume_up():
    current_volume = pygame.mixer.music.get_volume()
    current_volume += 0.05
    if current_volume > 1: current_volume = 1
    pygame.mixer.music.set_volume(current_volume)

def volume_down():
    current_volume = pygame.mixer.music.get_volume()
    current_volume -= 0.05
    if current_volume < 0: current_volume = 0
    pygame.mixer.music.set_volume(current_volume)

def select_folder_hotkey():
    global is_playing
    select_folder()
    play_current_song()
    is_playing = True
    
tkinter.Tk().withdraw() # prevents an empty tkinter window from appearing
pygame.mixer.init()
pygame.mixer.music.set_volume(1)
pygame.init()
screen = pygame.display.set_mode((100, 100), pygame.RESIZABLE)
if os.path.exists(cache_file):
    with open(cache_file, 'rb') as f:
        music_directory = pickle.load(f)
        mp3_files = get_mp3_files(music_directory)
else:
    select_folder()
play_current_song()
is_playing = True
while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.mixer.music.pause()
            pygame.mixer.music.unload()
            pygame.mixer.quit()
            pygame.quit()
            sys.exit()
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_p or event.key == pygame.K_SPACE: play_pause()
            elif event.key == pygame.K_j: volume_down()
            elif event.key == pygame.K_k: volume_up()
            elif event.key == pygame.K_c: select_folder_hotkey()
    if is_playing and not pygame.mixer.music.get_busy():
        switch_songs()
    screen.fill((30, 30, 30))
    pygame.display.flip()
    time.sleep(0.1)