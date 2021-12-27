import React from "react";
import { View, Text, TextInput } from "react-native";
import { LinearGradient } from "expo-linear-gradient";

import THEME from "src/constants/theme";
import styles from "./InitScreen.style";

function InitScreen() {
  return (
    <View style={styles.body}>
      <LinearGradient
        style={styles.container}
        colors={[THEME.colors.primary, THEME.colors.accent]}>
        <Text style={styles.title}>Login</Text>
        <Text style={styles.subtitle}>Using your phone number</Text>
        <TextInput
          style={styles.input}
          placeholder='Enter phone number'
          keyboardType='number-pad'
        />
      </LinearGradient>
    </View>
  );
}

export default InitScreen;
