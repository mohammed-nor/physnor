import 'dart:math' as math;

/// Shared validation helpers for the ChemNOR scientific models.
class ChemNORValidation {
  ChemNORValidation._();

  static void requirePositiveFinite(
    String name,
    double value, {
    bool allowZero = false,
  }) {
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError.value(value, name, 'must be a finite number');
    }
    if (allowZero) {
      if (value < 0) {
        throw ArgumentError.value(
          value,
          name,
          'must be greater than or equal to zero',
        );
      }
    } else if (value <= 0) {
      throw ArgumentError.value(value, name, 'must be greater than zero');
    }
  }

  static void requireFinite(String name, double value) {
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError.value(value, name, 'must be a finite number');
    }
  }

  static void requireNonNegativeFinite(String name, double value) {
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError.value(value, name, 'must be a finite number');
    }
    if (value < 0) {
      throw ArgumentError.value(
        value,
        name,
        'must be greater than or equal to zero',
      );
    }
  }

  static void requireTemperatureK(String name, double temperatureK) {
    requirePositiveFinite(name, temperatureK);
    if (temperatureK <= 0) {
      throw ArgumentError.value(
        temperatureK,
        name,
        'absolute temperature must be positive',
      );
    }
  }

  static void requireProbability(String name, double value) {
    if (value.isNaN || value.isInfinite) {
      throw ArgumentError.value(value, name, 'must be a finite number');
    }
    if (value < 0 || value > 1) {
      throw ArgumentError.value(
        value,
        name,
        'probability must be between 0 and 1',
      );
    }
  }

  static void requireLogArgument(String name, double value) {
    if (value <= 0) {
      throw ArgumentError.value(
        value,
        name,
        'logarithm argument must be positive',
      );
    }
  }

  static void requireSqrtArgument(String name, double value) {
    if (value < 0) {
      throw ArgumentError.value(
        value,
        name,
        'square root argument must be non-negative',
      );
    }
  }

  static void requireNonZero(String name, double value) {
    if (value == 0) {
      throw ArgumentError.value(value, name, 'must not be zero');
    }
  }

  static void requirePositiveLogArgument(String name, double value) {
    requireLogArgument(name, value);
  }

  static double safeExp(double x) {
    if (x > 700) {
      return double.infinity;
    }
    if (x < -745) {
      return 0.0;
    }
    return math.exp(x);
  }
}
