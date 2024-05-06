// android-as-linux.js
Object.defineProperty(process, "platform", {
  get() {
    return "linux";
  },
});
