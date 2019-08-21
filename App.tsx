/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, {useEffect, useState} from 'react';
import {
  StyleSheet,
  View,
  Button,
  LayoutAnimation,
  UIManager,
} from 'react-native';
import VolumeManager from './VolumeManager';
import VolumeSlider from './VolumeSlider';

// tslint:disable-next-line:no-unused-expression
UIManager.setLayoutAnimationEnabledExperimental &&
  UIManager.setLayoutAnimationEnabledExperimental(true);

const App = () => {
  const [volume, setVolume] = useState(0);

  useEffect(() => {
    VolumeManager.currentVolume(setVolume);
  }, []);

  const mute = () => {
    VolumeManager.mute();
    LayoutAnimation.easeInEaseOut();
    setVolume(0);
  };

  const increaseVolume = () => {
    VolumeManager.incrementVolume().then(value => {
      LayoutAnimation.easeInEaseOut();
      setVolume(value);
    });
  };

  const decreaseVolume = () => {};

  return (
    <View style={styles.container}>
      <View style={styles.centerContainer}>
        <VolumeSlider value={volume} />
        <Button title="Mute" onPress={mute} />
        <Button title="Increase Volume" onPress={increaseVolume} />
        <Button title="Decrease Volume" onPress={decreaseVolume} />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  volumeText: {
    textAlign: 'center',
  },
  centerContainer: {
    width: '100%',
    height: 200,
    justifyContent: 'space-between',
  },
});

export default App;
