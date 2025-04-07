#include "Light.h"

Light::Light(const Point3D& pos, float intensity = 10000.0f) : position(pos), intensity(intensity) {}

float Light::getLightIntensityAtPoint(const Point3D& point) const {
    // Calcul simplifié pour avoir un intensité de lumière
    float distance = point.distance(position);
    return intensity / (distance*distance); // Inverse du carré de la distance
}