import React, {FC} from 'react';
import {StyleSheet, View} from 'react-native';

interface VolumeSliderProps {
  value: number;
}

const VolumeSlider: FC<VolumeSliderProps> = props => {
  return (
    <View style={styles.container}>
      <View style={{ backgroundColor: 'black', flex: props.value }} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    marginHorizontal: 24,
    backgroundColor: 'gray',
    height: 10,
    borderRadius: 5,
    overflow: 'hidden',
  },
});

export default VolumeSlider;
