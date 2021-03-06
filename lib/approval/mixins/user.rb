module Approval
  module Mixins
    module User
      extend ActiveSupport::Concern

      included do
        has_many :approval_requests, class_name: :"Approval::Request", foreign_key: :request_user_id
        has_many :approval_comments, class_name: :"Approval::Comment", foreign_key: :user_id
      end

      def request_for_create(records, reason:)
        Approval::RequestForm::Create.new(user: self, reason: reason, records: records)
      end

      def request_for_update(records, reason:)
        Approval::RequestForm::Update.new(user: self, reason: reason, records: records)
      end

      def request_for_destroy(records, reason:)
        Approval::RequestForm::Destroy.new(user: self, reason: reason, records: records)
      end

      def cancel_request(request, reason:)
        Approval::RespondForm::Cancel.new(user: self, reason: reason, request: request)
      end

      def approve_request(request, reason:)
        Approval::RespondForm::Approve.new(user: self, reason: reason, request: request)
      end

      def reject_request(request, reason:)
        Approval::RespondForm::Reject.new(user: self, reason: reason, request: request)
      end
    end
  end
end
