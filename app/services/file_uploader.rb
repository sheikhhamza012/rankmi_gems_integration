class FileUploader
    def self.upload(file)
        s3 = Aws::S3::Resource.new
        key = "#{Time.now.to_i.to_s}#{File.extname(file)}"
        obj = s3.bucket(ENV['AWS_BUCKET']).object(key)
        obj.upload_file(file.to_io)
        return obj.public_url
    end
end