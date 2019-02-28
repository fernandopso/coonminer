require 'rails_helper'

RSpec.describe Crawlers::Tokens::CollectTweetsWorker do
  describe '.perform' do
    subject { described_class.new.perform }

    context 'when found a token to perform' do
      before do
        @token = create(:token)
      end

      context 'when no has enqueued max jobs' do
        before do
          expect_any_instance_of(Sidekiq::Stats).to receive(:enqueued).and_return(0)
        end

        let(:collector) { double }

        it do
          expect(Collect::Tweets).to receive(:new).with(@token).and_return(collector)
          expect(collector).to receive(:call)

          subject

          expect(@token.reload.collect_at).not_to be nil
        end
      end

      context 'when has enqueued max jobs' do
        before do
          expect_any_instance_of(Sidekiq::Stats)
            .to receive(:enqueued)
            .and_return(described_class::MAX_JOBS_TO_ENQUEUE)
        end

        it do
          expect(Collect::Tweets).to_not receive(:new)

          subject

          expect(@token.reload.collect_at).to be nil
        end
      end
    end

    context 'when not found a token to perform' do
      it do
        expect(Collect::Tweets).to_not receive(:new)
        subject
      end
    end

    context 'when could not obtain a connection from the pool to select a token' do
      before do
        expect(Token).to receive(:active).and_raise(ActiveRecord::ConnectionTimeoutError)
      end

      it 'should enqueue a job to perform async' do
        expect(Crawlers::Tokens::CollectTweetsWorker).to receive(:perform_async).once
        expect(Rails.logger).to receive(:info).once
        expect_any_instance_of(Sidekiq::Stats).to_not receive(:enqueued).once
        subject
      end
    end
  end
end
