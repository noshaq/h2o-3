module h2ocore {
  requires jdk.unsupported;
  requires java.management;
  requires log4j;
  provides org.apache.log4j.H2OPropertyConfigurator with org.apache.log4j.H2OPropertyConfigurator;
}