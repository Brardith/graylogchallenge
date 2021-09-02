resource "aws_cloudwatch_dashboard" "www-bds-code" {
  dashboard_name = "www-bds-code"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 12,
            "width": 12,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/CloudFront", "Requests", "Region", "Global", "DistributionId", "EJIWNGD1ME8AO" ]
                ],
                "region": "us-east-1",
                "title": "Requests (sum)",
                "yAxis": {
                    "left": {
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": false
                    }
                },
                "stat": "Sum"
            }
        },
        {
            "height": 12,
            "width": 12,
            "y": 0,
            "x": 12,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/CloudFront", "BytesUploaded", "Region", "Global", "DistributionId", "EJIWNGD1ME8AO" ],
                    [ ".", "BytesDownloaded", ".", ".", ".", "." ]
                ],
                "region": "us-east-1",
                "title": "Data transfer",
                "yAxis": {
                    "left": {
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": false
                    }
                }
            }
        },
        {
            "height": 12,
            "width": 12,
            "y": 12,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/CloudFront", "TotalErrorRate", "Region", "Global", "DistributionId", "EJIWNGD1ME8AO" ],
                    [ ".", "4xxErrorRate", ".", ".", ".", ".", { "label": "Total4xxErrors" } ],
                    [ ".", "5xxErrorRate", ".", ".", ".", ".", { "label": "Total5xxErrors" } ],
                    [ { "expression": "(m4+m5+m6)/m7*100", "label": "5xxErrorByLambdaEdge", "id": "e1" } ],
                    [ "AWS/CloudFront", "LambdaExecutionError", "Region", "Global", "DistributionId", "EJIWNGD1ME8AO", { "id": "m4", "stat": "Sum", "visible": false } ],
                    [ ".", "LambdaValidationError", ".", ".", ".", ".", { "id": "m5", "stat": "Sum", "visible": false } ],
                    [ ".", "LambdaLimitExceededErrors", ".", ".", ".", ".", { "id": "m6", "stat": "Sum", "visible": false } ],
                    [ ".", "Requests", ".", ".", ".", ".", { "id": "m7", "stat": "Sum", "visible": false } ]
                ],
                "region": "us-east-1",
                "title": "Error rate (as a percentage of total requests)",
                "yAxis": {
                    "left": {
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": false
                    }
                }
            }
        }
    ]
}
EOF
}

resource "aws_cloudwatch_dashboard" "bds-code" {
  dashboard_name = "bds-code"

  dashboard_body = <<EOF
{
    "widgets": [
        {
            "height": 12,
            "width": 12,
            "y": 0,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/CloudFront", "Requests", "Region", "Global", "DistributionId", "E3G3GE3Y0ORGH4" ]
                ],
                "region": "us-east-1",
                "title": "Requests (sum)",
                "yAxis": {
                    "left": {
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": false
                    }
                },
                "stat": "Sum"
            }
        },
        {
            "height": 12,
            "width": 12,
            "y": 0,
            "x": 12,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/CloudFront", "BytesUploaded", "Region", "Global", "DistributionId", "E3G3GE3Y0ORGH4" ],
                    [ ".", "BytesDownloaded", ".", ".", ".", "." ]
                ],
                "region": "us-east-1",
                "title": "Data transfer",
                "yAxis": {
                    "left": {
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": false
                    }
                }
            }
        },
        {
            "height": 12,
            "width": 12,
            "y": 12,
            "x": 0,
            "type": "metric",
            "properties": {
                "view": "timeSeries",
                "stacked": false,
                "metrics": [
                    [ "AWS/CloudFront", "TotalErrorRate", "Region", "Global", "DistributionId", "E3G3GE3Y0ORGH4" ],
                    [ ".", "4xxErrorRate", ".", ".", ".", ".", { "label": "Total4xxErrors" } ],
                    [ ".", "5xxErrorRate", ".", ".", ".", ".", { "label": "Total5xxErrors" } ],
                    [ { "expression": "(m4+m5+m6)/m7*100", "label": "5xxErrorByLambdaEdge", "id": "e1" } ],
                    [ "AWS/CloudFront", "LambdaExecutionError", "Region", "Global", "DistributionId", "E3G3GE3Y0ORGH4", { "id": "m4", "stat": "Sum", "visible": false } ],
                    [ ".", "LambdaValidationError", ".", ".", ".", ".", { "id": "m5", "stat": "Sum", "visible": false } ],
                    [ ".", "LambdaLimitExceededErrors", ".", ".", ".", ".", { "id": "m6", "stat": "Sum", "visible": false } ],
                    [ ".", "Requests", ".", ".", ".", ".", { "id": "m7", "stat": "Sum", "visible": false } ]
                ],
                "region": "us-east-1",
                "title": "Error rate (as a percentage of total requests)",
                "yAxis": {
                    "left": {
                        "showUnits": false
                    },
                    "right": {
                        "showUnits": false
                    }
                }
            }
        }
    ]
}
EOF
}
