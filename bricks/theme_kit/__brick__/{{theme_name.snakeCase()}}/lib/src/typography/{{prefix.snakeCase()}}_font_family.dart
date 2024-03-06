class {{prefix.pascalCase()}}FontFamily {
  const {{prefix.pascalCase()}}FontFamily._(this.name);
  final String name;

  static const {{prefix.pascalCase()}}FontFamily poppins = {{prefix.pascalCase()}}FontFamily._("Poppins");
  //static const {{prefix.pascalCase()}}FontFamily inter = {{prefix.pascalCase()}}FontFamily._("Inter");
}