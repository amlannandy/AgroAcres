import { StyleSheet } from "react-native";
import THEME from "../../constants/theme";

const styles = StyleSheet.create({
  body: {
    flex: 1,
  },
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "flex-start",
    paddingHorizontal: 20,
  },
  title: {
    fontSize: 32,
    color: THEME.colors.white,
  },
  subtitle: {
    fontSize: 16,
    color: THEME.colors.white,
  },
  input: {
    fontSize: 16,
    alignSelf: "stretch",
    borderRadius: 25,
    marginVertical: 10,
    paddingVertical: 7.5,
    paddingHorizontal: 15,
    backgroundColor: THEME.colors.white,
  },
});

export default styles;
