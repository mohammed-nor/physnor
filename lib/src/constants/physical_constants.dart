/// Fundamental physical constants expressed in SI units.
class PhysicalConstants {
  const PhysicalConstants._();

  /// Boltzmann constant in J/K.
  static const double boltzmann = 1.380649e-23;

  /// Avogadro constant in mol^-1.
  static const double avogadro = 6.02214076e23;

  /// Universal gas constant in J/(mol·K).
  static const double universalGasConstant = 8.31446261815324;

  /// Planck constant in J·s.
  static const double planck = 6.62607015e-34;

  /// Reduced Planck constant in J·s.
  static const double hBar = planck / (2 * 3.141592653589793);

  /// Speed of light in vacuum in m/s.
  static const double speedOfLight = 299792458.0;

  /// Elementary charge in C.
  static const double elementaryCharge = 1.602176634e-19;

  /// Faraday constant in C/mol.
  static const double faraday = elementaryCharge * avogadro;

  /// Stefan-Boltzmann constant in W/(m^2·K^4).
  static const double stefanBoltzmann = 5.670374419e-8;

  /// Vacuum permittivity in F/m.
  static const double vacuumPermittivity = 8.8541878128e-12;

  /// Vacuum permeability in H/m.
  static const double vacuumPermeability = 4e-7 * 3.141592653589793;

  /// Electron mass in kg.
  static const double electronMass = 9.1093837015e-31;

  /// Proton mass in kg.
  static const double protonMass = 1.67262192369e-27;

  /// Standard gravity in m/s^2.
  static const double standardGravity = 9.80665;

  /// Pi constant.
  static const double pi = 3.141592653589793;
}
