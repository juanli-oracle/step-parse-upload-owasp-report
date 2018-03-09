# Parse and Upload OWASP Report Step for wercker

A wercker step parsing the OWASP dependency-check-report.json to generate notes and occurrences and upload to grafeas server.

## OWASP dependency-check Information

For more information on OWASP dependency-check tool please see the [OWASP website](https://www.owasp.org/index.php/OWASP_Dependency_Check) or [documentation on GitHub](https://jeremylong.github.io/DependencyCheck/)

## Requirements

The wercker `box` that you run your pipeline should use or extend the `openjdk` container [from Docker Hub](https://hub.docker.com/_/openjdk/).

The `curl` and `unzip` utilties are also expected in order to download the binary distriubtion to the wercker cache directory.

## Usage

To use the step, add the step to your pipeline (`wercker.yml`) with the appropriate properties, as in the example below:

```
  steps:
    - juanli-oracle/parse-upload-owasp-report:
        project: application
        dependencyReportJSON: $WERCHER_CACHE_DIR/dependency-check-report.json
        urlGrafeas: http://localhost:80
```

### Parameters

## Example

