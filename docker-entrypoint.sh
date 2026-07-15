#!/bin/sh

echo "====================================="
echo "Starting Drupal Container..."
echo "====================================="

echo "Rebuilding Drupal cache..."

vendor/bin/drush cr -y

echo "Cache rebuild completed."

exec apache2-foreground
