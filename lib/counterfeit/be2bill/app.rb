require 'counterfeit/base_app'
require 'sinatra/base'
require 'sinatra/contrib'
require 'sinatra/json'

module Counterfeit
  module Be2Bill
    ENDPOINT = 'secure-test.be2bill.com'

    class App < Counterfeit::BaseApp
      register Sinatra::Contrib

      post %r{/front/service/rest/process(.php)?} do
        response =
          if params[:method] == 'capture'
            handle_capture
          elsif params[:method] == 'void'
            handle_void
          elsif params[:method] == 'authorization' && params[:params][:CREATEALIAS].present?
            handle_card_storage
          else
            handle_authorization
          end

        json(response)
      end

      private

      def handle_capture
        if params[:params][:TRANSACTIONID] == 'B37352344'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5004' }
        elsif params[:params][:TRANSACTIONID] == 'B37352345'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5002' }
        elsif params[:params][:TRANSACTIONID] == 'B37352343'
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '5001' }
        else
          { 'OPERATIONTYPE' => 'capture', 'EXECCODE' => '0000' }
        end
      end

      def handle_authorization
        if params[:params][:AMOUNT].to_f == 100_00
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '5001', 'MESSAGE' => 'Exchange protocol failure.' }
        elsif params[:params][:AMOUNT].to_f == 200_00
          {
            'OPERATIONTYPE' => 'authorization',
            'EXECCODE' => '0001',
            'MESSAGE' => '3D secure authentication required.',
            'TRANSACTIONID' => 'B11499473',
            'REDIRECTHTML' => 'PGh0bWw+CiAgICA8aGVhZD4KICAgICAgICA8bWV0YSBjaGFyc2V0PSJ1dGYtOCIgLz4'\
            'KICAgICAgICA8dGl0bGU+UHJvY2Vzc2luZyBwYXltZW50IC4uLjwvdGl0bGU+CiAgICAgICAgPGxpbmsgcmVs'\
            'PSJzdHlsZXNoZWV0IiBocmVmPSJodHRwczovL3NlY3VyZS10ZXN0LmJlMmJpbGwuY29tL2Zyb250Ly9yZWRpc'\
            'mVjdC9jc3MvbG9hZGluZy1wYWdlLmNzcyIvPgogICAgICAgIDxzY3JpcHQgdHlwZT0idGV4dC9qYXZhc2NyaX'\
            'B0Ij4KICAgICAgICA8IS0tCiAgICAgICAgICAgIHZhciB0YXJnZXQgPSAibWFpbiI7CiAgICAgICAgICAgIGZ'\
            '1bmN0aW9uIE9uTG9hZEV2ZW50KCkKICAgICAgICAgICAgewogICAgICAgICAgICAgICAgaWYgKHRhcmdldCA9'\
            'PSAncG9wdXAnKQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgIC8vIFBvcHVwIGNhc2UKI'\
            'CAgICAgICAgICAgICAgICAgICB2YXIgcG9wdXAgPSB3aW5kb3cub3BlbignYWJvdXQ6YmxhbmsnLCAncG9wdX'\
            'AnLCAnaGVpZ2h0PTQwMCwgd2lkdGg9MzkwLCBzdGF0dXM9eWVzLCBkZXBlbmRlbnQ9bm8sIHNjcm9sbGJhcnM'\
            '9eWVzJyk7CgogICAgICAgICAgICAgICAgICAgIGlmIChwb3B1cCA9PSBudWxsIHx8ICFwb3B1cCB8fCBwb3B1'\
            'cC5jbG9zZWQpCiAgICAgICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICAvLyBQb3B1c'\
            'CBub3Qgb3BlbmVkLCBjbG9zZWQgb3IgZmFpbGVkCiAgICAgICAgICAgICAgICAgICAgICAgIGRvY3VtZW50Ln'\
            'J1bjNkc0Zvcm0uc3VibWl0KCk7CiAgICAgICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgICAgIGV'\
            'sc2UKICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAgIGRvY3VtZW50LnJ1bjNk'\
            'c0Zvcm0uVGVybVVybC52YWx1ZSA9IGRvY3VtZW50LnJ1bjNkc0Zvcm0uVGVybVVybC52YWx1ZSArICI/cG9wd'\
            'XA9eWVzIjsKICAgICAgICAgICAgICAgICAgICAgICAgZG9jdW1lbnQucnVuM2RzRm9ybS50YXJnZXQgPSAncG'\
            '9wdXAnOwogICAgICAgICAgICAgICAgICAgICAgICBkb2N1bWVudC5ydW4zZHNGb3JtLnN1Ym1pdCgpOwogICA'\
            'gICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgIGVsc2UgaWYgKHRh'\
            'cmdldCA9PSAndG9wJykKICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAvLyBUb3AgY2FzZ'\
            'QogICAgICAgICAgICAgICAgICAgIGRvY3VtZW50LnJ1bjNkc0Zvcm0udGFyZ2V0ID0gJ19wYXJlbnQnOwogIC'\
            'AgICAgICAgICAgICAgICAgIGRvY3VtZW50LnJ1bjNkc0Zvcm0uc3VibWl0KCk7CiAgICAgICAgICAgICAgICB'\
            '9CiAgICAgICAgICAgICAgICBlbHNlCiAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgLy8g'\
            'U3RhbmRhcmQgYW5kIG90aGVyIGNhc2VzCiAgICAgICAgICAgICAgICAgICAgZG9jdW1lbnQucnVuM2RzRm9yb'\
            'S5zdWJtaXQoKTsKICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgfQogICAgICAgIC8vLS0+CiAgICAgIC'\
            'AgPC9zY3JpcHQ+CiAgICA8L2hlYWQ+CiAgICA8Ym9keSBPbkxvYWQ9Ik9uTG9hZEV2ZW50KCkiPgogICAgICA'\
            'gIDxmb3JtIG5hbWU9InJ1bjNkc0Zvcm0iIGFjdGlvbj0iaHR0cHM6Ly9zZWN1cmUtdGVzdC5iZTJiaWxsLmNv'\
            'bS9mYWtlLXNlcnZpY2UvYWNzL2JlMmJpbGxfZW4ucGhwIiBtZXRob2Q9IlBPU1QiPgogICAgICAgICAgICA8c'\
            'D4KICAgIDxpbWcgc3JjPSJodHRwczovL3NlY3VyZS10ZXN0LmJlMmJpbGwuY29tL2Zyb250Ly9yZWRpcmVjdC'\
            '9pbWcvbG9hZC1pY29uLmdpZiIgYWx0PSJsb2FkaW5nIi8+CjwvcD4KPHA+CiAgICBQYXltZW50IHByb2Nlc3N'\
            'pbmcgLi4uCjwvcD4KICAgICAgICAgICAgPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iUGFSZXEiIHZhbHVl'\
            'PSJlSnh0VVExcndqQVEvU3ZGSDlCTGEvMm9uSUdxSFN2TTRqckhCbU1ic1I3YVlWdE5XenYvL1pKYWRZTUZBd'\
            'mZ1NVY0ZTczQzVsVVN6SjRvclNSem5WQlJpUTBheUhuY1lzem9jRjE1RUI0NUhra1dTWjl3eW1Xa2pYS0Fha1'\
            'BGV1pDVkhFUjhtUWNpZGZ0L3V1UWd0eEpSa01PT1JIeTY5U2ZBUXZQZ1RDK0hjeEV5a3hDUEtTckZLZGtsTks'\
            '0U21oWEZlWmFVODhhSERFQzRBSzduajI3TGNqd0RxdWpaWFpLdXhuUm5uS1NCb0V1Rm1aMUhwcWxCaTM4bWFC'\
            'MU52ODgrdDV6Ti9qS0JmNEZxVXhHMW1PY3l4bVBIMjhXNnd3YWpuakxwRGhJWkRrV29uM0grT0RKc3hreWx2Y'\
            'lF2MytqZnZEQlNucWQ4dFZPbEt5dUlUZHdkSzdvcVF2dmQ1Um5vSTRWb2ozTXhQNzNXeWNhbmlDcnRmNFRING'\
            'RQUGhJTHFydW9sMFNjNGZkZElOcmJVU0ZkT3JPbzJZQmdoYUFOb2xRcnRlVmYxWit3OEU4YXNXIiAvPgogICA'\
            'gICAgICAgICA8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJUZXJtVXJsIiB2YWx1ZT0iaHR0cHM6Ly9zZWN1'\
            'cmUtdGVzdC5iZTJiaWxsLmNvbS9mcm9udC9wcml2YXRlLzNkcy9jYWxsYmFjay5waHAiIC8+CiAgICAgICAgI'\
            'CAgIDxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9Ik1EIiB2YWx1ZT0iICAgICAgICAgICBBMTE1MzQxNjAsMj'\
            'AwMDAsLCwsbm8sQ09JTkhPVVNFLDExNjA5LE5XRmpZMkpqTjJRMFpEWXpaamN1T0RBM01ESXhNREk9LDdhZWJ'\
            'hYmQ4ZTIzYTg2Yzg0YzcwNjY0N2QzNjgwNGY4Njc1ZWE4MjEyZTg3MzJjNzcwNTZiYWFhNDM2OTViZGIsMSwz'\
            'LjAsbm8iIC8+CiAgICAgICAgICAgIDxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImJhc2VVcmwiICB2YWx1Z'\
            'T0iIiAvPgogICAgICAgIDwvZm9ybT4KICAgIDwvYm9keT4KPC9odG1sPg==',
            '3DSECUREHTML' => 'PGh0bWw+CiAgICA8aGVhZD4KICAgICAgICA'
          }
        else
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '0000', 'MESSAGE' => 'Operation succeeded.', 'TRANSACTIONID' => 'B11499474' }
        end
      end

      def handle_card_storage
        if params[:params][:CARDFULLNAME] == 'Wrong name'
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '5001', 'MESSAGE' => 'Exchange protocol failure.' }
        else
          { 'OPERATIONTYPE' => 'authorization', 'EXECCODE' => '0000', 'MESSAGE' => 'Operation succeeded.', 'TRANSACTIONID' => 'B11499475', 'DESCRIPTOR' => 'RENTABILITEST', 'ALIAS' => 'A1-1d252795-1084-4bb5-8260-766bc76d2f6b' }
        end
      end

      def handle_void
        if params[:params][:TRANSACTIONID] == 'B22499473'
          { 'OPERATIONTYPE' => 'void', 'EXECCODE' => '5001' }
        else
          { 'OPERATIONTYPE' => 'void', 'EXECCODE' => '0000' }
        end
      end
    end
  end
end
