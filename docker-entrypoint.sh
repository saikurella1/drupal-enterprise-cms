#!/bin/sh

echo "====================================="
echo "Starting Drupal Container..."
echo "====================================="

echo "Importing Drupal configuration..."

vendor/bin/drush cim -y

echo "Configuration import completed."

echo "Rebuilding Drupal cache..."

vendor/bin/drush cr -y

echo "Cache rebuild completed."
exec apache2-foreground
