import React from "react";
import { View, Text, TextInput } from "react-native";

import styles from "./InitScreen.style";

function InitScreen() {
  return (
    <View style={styles.body}>
      <Text style={styles.title}>Login</Text>
      <Text style={styles.subtitle}>Using your phone number</Text>
      <TextInput
        style={styles.input}
        placeholder='Enter phone number'
        keyboardType='number-pad'
      />
    </View>
  );
}

export default InitScreen;
