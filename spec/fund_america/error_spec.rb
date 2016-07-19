require 'spec_helper'

describe FundAmerica::Error do
  context '#error_message' do
    before(:all) do
      @message_401 = 'Authentication error. Your API key is incorrect'
      @message_403 = "Not authorized. You don't have permission to take action on a particular resource. It may not be owned by your account or it may be in a state where you action cannot be taken (such as attempting to cancel an invested investment)"
      @message_404 = 'Resource was not found'
      @message_422 = 'This usually means you are missing or have supplied invalid parameters for a request: {}'
      @message_500_no_details = "Internal server error. Something went wrong. This is a bug. Please report it to support immediately. Unable to retrieve details from response body."
      @message_500_with_details = "Internal server error. Something went wrong. This is a bug. Please report it to support immediately. Parsed response details scraped from error page: <dl class='dl-horizontal'><dt>URL</dt><dd>https://sandbox.fundamerica.com/api/test_mode/entities/AbCdEfGhIjKlMnOpQrStUv</dd><dt>Browser</dt><dd>Ruby</dd><dt>Request ID</dt><dd>aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa</dd></dl>"
      @message_other = 'An error occured. Please check parsed_response for details'
    end

    it 'must have an error message' do
      response = FundAmerica::Error.error_message(422, {})
      expect(response).not_to be nil
    end

    context '401 code' do
      before(:all) do
        @response = FundAmerica::Error.error_message(401, {})
      end

      it 'must match 401 error message when code is 401' do
        expect(@response).to eq(@message_401)
      end

      it 'must not match other error message when code is 401' do
        expect(@response).not_to eq(@message_other)
      end
    end

    context '403 code' do
      before(:all) do
        @response = FundAmerica::Error.error_message(403, {})
      end

      it 'must match 403 error message when code is 403' do
        expect(@response).to eq(@message_403)
      end

      it 'must not match other error message when code is 403' do
        expect(@response).not_to eq(@message_other)
      end
    end

    context '404 code' do
      before(:all) do
        @response = FundAmerica::Error.error_message(404, {})
      end

      it 'must match 404 error message when code is 404' do
        expect(@response).to eq(@message_404)
      end

      it 'must not match other error message when code is 404' do
        expect(@response).not_to eq(@message_other)
      end
    end

    context '422 code' do
      before(:all) do
        @response = FundAmerica::Error.error_message(422, {})
      end

      it 'must match 422 error message when code is 422' do
        expect(@response).to eq(@message_422)
      end

      it 'must not match other error message when code is 422' do
        expect(@response).not_to eq(@message_other)
      end
    end

    context '500 code' do
      before(:all) do
        @response = FundAmerica::Error.error_message(500, {})
      end

      it 'must match 500 error message when code is 500' do
        expect(@response).to eq(@message_500_no_details)
      end

      it 'must not match other error message when code is 500' do
        expect(@response).not_to eq(@message_other)
      end

      context 'with scraped details' do
        before(:all) do
          parsed_response = <<-END_OF_STRING
<html>
  <head>
    <meta charset='utf-8'>
    <meta content='width=device-width, initial-scale=1.0' name='viewport'>
    <link rel="stylesheet" media="all" href="/assets/application-aac58a24099b178e77c074a2f133940a3b6b5733a494104c9f1361f405206892.css" />
    <title> An unexpected error has occurred. | FundAmerica Technologies, LLC</title>
    <meta name="csrf-param" content="authenticity_token" />
    <meta name="csrf-token" content="vDVGXZ/82q4pLtENbuav0D57ubVIlbq5CXv/DapRupQsouivN5SUuGAGtclCYK5Vz6NsvtxYCbPKBrzuFu+Q4Q==" />
  </head>
  <body class='portal errors show'>
    <div id='wrapper'>
      <nav class='navbar-top' role='navigation'>
      <div class='navbar-header'>
        <button class='navbar-toggle btn btn-sm pull-right' data-target='.sidebar-collapse' data-toggle='collapse' type='button'>
          <i class='fa fa-bars'></i>
          Menu
        </button>
        <div class='navbar-brand'>
          <a style="color: #ffffff" href="/">FundAmerica</a>
        </div>
      </div>
      <div class='nav-top'>
        <div class='navbar-brand' style='color: #dd0000; font-weight: bold;'>
          Sandbox
        </div>
        <ul class='nav navbar-right'>
          <li class='dropdown'>
          <a class="dropdown-toggle" data-toggle="dropdown" href="#"><i class="fa fa-user"></i>
            <i class="fa fa-caret-down"></i>
            </a><ul class='dropdown-menu' style='left:inherit'>
            <li>
            <a href="/sign_in"><i class="fa fa-sign-in"></i> Sign In</a>
            </li>
            <li>
            <a href="/sign_up"><i class="fa fa-plus-circle"></i> Sign Up!</a>
            </li>
          </ul>
          </li>
        </ul>
      </div>
      </nav>


      <main>
      <div id='page-wrapper'>
        <div class='page-content'>
          <div class='row'>
            <div class='col-lg-12'>
              <div class='page-title'>
                <h1>
                  <i class="fa fa-warning text-red"></i> An unexpected error has occurred.
                </h1>
              </div>
            </div>
            <div class='col-lg-12'>
              <div class='notices'>
              </div>

            </div>
          </div>
          <div class='row'>
            <div class='col-lg-6'>
              <p class='lead'>Please contact <strong><a href="mailto:tech-support@fundamerica.com?body=Describe below what you were doing when you encountered this error%3A%0A%0A%0A ---%0A%0AError Details%3A%0A%0AURL%3A https%3A%2F%2Fsandbox.fundamerica.com%2Fapi%2Ftest_mode%2Fentities%2FAbCdEfGhIjKlMnOpQrStUv%0ABrowser%3A Ruby%0ARequest ID%3A aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa&amp;subject=Unexpected Error %28Request ID%3A aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa%29">technical support</a></strong> for assistance in resolving this error. Be sure to include the following information:</p>
            </div>
          </div>
          <div class='portlet portlet-default'>
            <div class='portlet-heading'>
              <div class='portlet-title'>
                <h4>Error Information</h4>
              </div>
              <div class='portlet-widgets'>

              </div>
              <div class='clearfix'></div>
            </div>
            <div class='portlet-body'>
              <dl class='dl-horizontal'>
                <dt>URL</dt>
                <dd>https://sandbox.fundamerica.com/api/test_mode/entities/AbCdEfGhIjKlMnOpQrStUv</dd>
                <dt>Browser</dt>
                <dd>Ruby</dd>
                <dt>Request ID</dt>
                <dd>aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa</dd>
              </dl>
            </div>

          </div>
          <div class='row'>
            <div class='col-lg-6'>
              <p>Additionally, remember to include any information about what you were attempting to do when encountering this problem.</p>
              <p>We apologize for any inconvenience this may have caused and will work to resolve it as soon as we are notified.</p>
            </div>
          </div>

        </div>
      </div>

      </main>
      <div class='footer'>
        <footer></footer>

      </div>
    </div>
    <script src="/assets/application-29a311454eb081dbd5089cb9d9a177ef506b27f20731ee9dda1dd11f3497f158.js"></script>

  </body>
</html>
          END_OF_STRING
          @response = FundAmerica::Error.error_message(500, parsed_response)
        end

        it 'must match 500 error message when code is 500' do
          expect(@response).to eq(@message_500_with_details)
        end
      end
    end

    it 'must match other error message when code is 123' do
      response = FundAmerica::Error.error_message(123, {})
      expect(response).to eq(@message_other)
    end
  end
end
