import {NativeModules} from 'react-native';

class VolumeManager {
  static currentVolume(handler: (value: number) => void) {
    NativeModules.VolumeManager.currentVolume(handler);
  }

  static incrementVolume(): Promise<number> {
    return NativeModules.VolumeManager.incrementVolume();
  }

  static decrementVolume(): Promise<number> {
    return NativeModules.VolumeManager.decrementVolume();
  }
}

export default VolumeManager;
