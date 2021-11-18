output gs-cloud-front {
    value = [
             module.cloudfront.cloudfront_distribution_domain_name,
             module.cloudfront.cloudfront_distribution_id,
             module.cloudfront.cloudfront_distribution_arn,
             module.cloudfront.cloudfront_distribution_caller_reference,
             module.cloudfront.cloudfront_distribution_status,
             module.cloudfront.cloudfront_distribution_trusted_signers,
             module.cloudfront.cloudfront_distribution_last_modified_time,
             module.cloudfront.cloudfront_distribution_in_progress_validation_batches,
             
             ]
  
}