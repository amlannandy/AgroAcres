import { createNativeStackNavigator } from "@react-navigation/native-stack";

import InitScreen from "../screens/InitScreen/InitScreen";
import HomeScreen from "../screens/HomeScreen/HomeScreen";
import LoginScreen from "../screens/LoginScreen/LoginScreen";
import UserInfoScreen from "../screens/UserInfoScreen/UserInfoScreen";

const Stack = createNativeStackNavigator();

function RootNavigator() {
  return (
    <Stack.Navigator screenOptions={{ headerShown: false }}>
      <Stack.Screen name='init' component={InitScreen} />
      <Stack.Screen name='home' component={HomeScreen} />
      <Stack.Screen name='login' component={LoginScreen} />
      <Stack.Screen name='user-info' component={UserInfoScreen} />
    </Stack.Navigator>
  );
}

export default RootNavigator;
