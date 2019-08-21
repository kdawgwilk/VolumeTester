import {NativeModules} from 'react-native';

const {VolumeModule} = NativeModules;

class VolumeManager {
  static mute() {
    VolumeModule.mute();
  }

  static currentVolume(handler: (value: number) => void) {
    VolumeModule.currentVolume(handler);
  }

  static incrementVolume(): Promise<number> {
    return VolumeModule.incrementVolume();
  }
}

export default VolumeManager;
