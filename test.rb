require 'zlib'
require 'rocketamf'
require "json"


def lang_decompress(file)
  data = File.read('l-ver927.lng')

  uncompressed_data = Zlib::Inflate.inflate(data)

  f = File.new('l-ver927.json', 'w')
  f.write(uncompressed_data)
  f.close
end


def dicts_decompress(file)
  data = File.read('dicts-ver353.amf')

  data = RocketAMF.deserialize(data, 3)

  f = File.new('dicts.json', 'w')
  f.write(data.to_json)
  f.close
end


