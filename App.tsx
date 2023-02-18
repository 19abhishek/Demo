/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * Generated with the TypeScript template
 * https://github.com/react-native-community/react-native-template-typescript
 *
 * @format
 */

import React, { useState } from 'react';
import {
  Button,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

const {NativeModules} = require('react-native');

// const RNCPPCode = NativeModules.RNCPPCode;

const {CalendarModule} = NativeModules;

// if (!RNCPPCode) {
//   throw new Error(`[RNCPPCode]: NativeModule: RNCPPCode is null.
// To fix this issue try these steps:
//   • Rebuild and restart the app.
//   • Run the packager with \`--clearCache\` flag.
//   • Run \`pod install\` in the \`ios\` directory and then rebuild and re-run the app.
// `);
// }

const Section: React.FC<{
  title: string;
}> = ({children, title}) => {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
};

const App = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const [xorVal, setXorVal] = useState('');
  const [shaVal, setShaVal] = useState('');
  const [multiply, setMultiply] = useState('');

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };
  const onPress = async () => {
    const eid = await CalendarModule.createCalendarEvent('testName', 'testLocation');
    console.log('eval', eid);
  };

  const mul = async () => {
    console.log('Inside multiply');
    const ans = await CalendarModule.multiply(5,6);
    setMultiply(ans);
    console.log('ans', ans);
  }

  const getXor = async () => {
    const ans = await CalendarModule.xor('hello', 'world');
    setXorVal(ans);
    console.log('Xor', ans);
  }

  const getSha = async () => {
    const ans = await CalendarModule.sha512('hello');
    setShaVal(ans);
    console.log('Sha', ans);
  }
  // const mul = async () => {
  //   const val = await RNCPPCode.multiply(3,8);
  //   const res = await RNCPPCode.xorString('Abhishek', 'Kumar');
  //   // const shaVal = await RNCPPCode.sha256('Abhishek');
  //   const shaVal5 = await RNCPPCode.sha512('Abhishek');
  //   const value = res.result;

  //   console.log('Sha', JSON.stringify(shaVal5.result).length);
    
  //   for(let val of value){
  //     console.log('i', JSON.stringify(val));
  //   }
  //   // console.log('Val', val, 'res', value);
  //   // for(const each of value) console.log(JSON.stringify(each));
  // }

  // mul();
  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <Button
      title="Click to invoke your native module!"
      color="#841584"
      onPress={onPress}
    />
        <Button
      title="Multiply"
      color="#841584"
      onPress={mul}
    />
        <Button
      title="XOR"
      color="#841584"
      onPress={getXor}
    />
        <Button
      title="Sha"
      color="#841584"
      onPress={getSha}
    />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Section title="Step One">
            Edit <Text style={styles.highlight}>App.tsx</Text> to change this
            screen and then come back to see your edits.
          </Section>
          <Section title="Xor">
            {`xor-${xorVal}`}
          </Section>
          <Section title="Sha">
            {`sha-${shaVal}`}
          </Section>
          <Section title="Multiply">
            {`multiply-${multiply}`}
          </Section>
          <Section title="Debug">
            <DebugInstructions />
          </Section>
          <Section title="Learn More">
            Read the docs to discover what to do next:
          </Section>
          <LearnMoreLinks />
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
