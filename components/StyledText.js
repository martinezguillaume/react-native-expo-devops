import React from 'react';
import { Text } from 'react-native';

export class MonoText extends React.Component {
  render() {
    const { style, color } = this.props;
    return (
      <Text {...this.props} style={[style, { fontFamily: 'space-mono' }, color && { color }]} />
    );
  }
}
