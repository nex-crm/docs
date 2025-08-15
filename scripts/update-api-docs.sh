#!/bin/bash

# Script to automate OpenAPI documentation updates for Mintlify
# Run this script whenever your OpenAPI specification is updated

set -e

echo "🚀 Starting API documentation update..."

# Ensure we're in the docs directory
cd "$(dirname "$0")/.."

# Backup current OpenAPI spec
if [ -f "api-reference/openapi.json" ]; then
    echo "📦 Backing up current OpenAPI spec..."
    cp api-reference/openapi.json api-reference/openapi.json.backup
fi

# Convert Swagger 2.0 to OpenAPI 3.0 if needed
echo "🔄 Converting OpenAPI specification..."
swagger2openapi api-reference/openapi.json -o api-reference/openapi.json

# Validate the OpenAPI specification
echo "✅ Validating OpenAPI specification..."
if ! mintlify openapi-check api-reference/openapi.json; then
    echo "❌ OpenAPI validation failed. Please check your specification."
    exit 1
fi

# Remove existing auto-generated endpoint files
echo "🧹 Cleaning up existing endpoint files..."
rm -rf api-reference/lists api-reference/objects api-reference/records

# Generate new endpoint files from OpenAPI spec
echo "📝 Generating endpoint documentation..."
npx @mintlify/scraping@latest openapi-file api-reference/openapi.json -o api-reference

# Extract navigation structure and save it
echo "📋 Extracting navigation structure..."
npx @mintlify/scraping@latest openapi-file api-reference/openapi.json -o api-reference > temp_nav_output.txt 2>&1

# Extract the navigation object from the output
if grep -A 50 "navigation object suggestion:" temp_nav_output.txt > navigation_suggestion.json; then
    echo "💡 Navigation structure saved to navigation_suggestion.json"
    echo "   Please update your docs.json navigation section with the suggested structure."
else
    echo "⚠️  Could not extract navigation structure automatically."
fi

# Clean up temporary files
rm -f temp_nav_output.txt

echo "✨ API documentation update complete!"
echo ""
echo "📚 Next steps:"
echo "   1. Review the generated files in api-reference/"
echo "   2. Update docs.json navigation if navigation_suggestion.json was created"
echo "   3. Customize individual endpoint files as needed"
echo "   4. Test your documentation with: mintlify dev"
echo ""
echo "🔗 Learn more about customization:"
echo "   https://mintlify.com/docs/api-playground/openapi/setup"
