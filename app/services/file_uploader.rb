class FileUploader
    def self.upload(stream)
        s3 = Aws::S3::Resource.new
        key = "#{Time.now.to_i.to_s}.xlsx"
        obj = s3.bucket(ENV['AWS_BUCKET']).object(key)
        # obj.upload_file(file.to_io)
        obj.put(body: stream)
        return obj.public_url
    end
end