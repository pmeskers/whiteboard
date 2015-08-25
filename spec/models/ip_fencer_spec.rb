require 'rails_helper'

describe IpFencer do
  describe '#authorized?' do
    let(:validIp1) { IPAddr.new('127.0.0.8') }
    let(:validIp2) { IPAddr.new('168.2.1.3') }
    let(:authorized_ips) { [validIp1, validIp2] }
    let(:mapper) { IpFencer.new(authorized_ips) }

    it 'can tell if a ip is authorized' do
      expect(mapper.authorized?('127.0.0.8')).to eq true
      expect(mapper.authorized?('168.2.1.3')).to eq true
    end

    it 'returns false with an invalid address' do
      expect(mapper.authorized?('100.255.13.88')).to eq false
    end
  end
end
