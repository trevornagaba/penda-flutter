const String CHARGE_ENDPOINT =
    "https://api.ravepay.co/flwv3-pug/getpaidx/api/charge";
const String VALIDATE_CHARGE_ENDPOINT =
    "https://api.ravepay.co/flwv3-pug/getpaidx/api/validatecharge";
const String REQUERY_ENDPOINT =
    "https://api.ravepay.co/flwv3-pug/getpaidx/api/verify/mpesa";
const String PAYOUTS_ENDPOINT =
    "https://api.ravepay.co/v2/gpx/transfers/create";
const String CREATE_PAYOUT_BENEFICIARY = "https://api.ravepay.co/v2/gpx/transfers/beneficiaries/create";

// // Collect keys
// const String PUBLIC_KEY = 'FLWPUBK-4537f222cc86151ad3e157ce3118275d-X';
// const String SECRET_KEY = 'FLWSECK-607528cb88649a20c27418f874345bf9-X';
// const String ENCRYPTION_KEY = '607528cb88647589a269d5bb';

// Penda keys
// const String PUBLIC_KEY = 'FLWPUBK-2e016454ce90973c8fd96325c9f3660d-X';
// const String SECRET_KEY = 'FLWSECK-6231cc17e311c91045549c49605699fd-X';
// const String ENCRYPTION_KEY = '6231cc17e3115c996fc4831b';
// const VERIFICATION_API_BASE_URL="https://penda-payout.herokuapp.com/";

// Penda Sandbox keys

// const String PUBLIC_KEY = 'FLWPUBK_TEST-8895337bccb448cb083af86caf869843-X';
// const String SECRET_KEY = 'FLWSECK_TEST-8cd3d6881da4ab2822f529f6f231aea5-X';
// const String ENCRYPTION_KEY = 'FLWSECK_TESTb73ee2ebcd32';
// const VERIFICATION_API_BASE_URL="http://192.168.43.155:8000/webhook-view";

// Collect Sandbox keys

const String PUBLIC_KEY = 'FLWPUBK_TEST-383190a342124441f57f57b2633f1b2e-X';
const String SECRET_KEY = 'FLWSECK_TEST-de145617df566f0ef4f07dbda2cb0e59-X';
const String ENCRYPTION_KEY = 'FLWSECK_TESTb875efecd6db';
const VERIFICATION_API_BASE_URL =
    "https://collect-payout.herokuapp.com/webhook-view";

const currency = 'UGX';
const paymentType = 'mobilemoneyuganda';
const receivingCountry = 'NG';
const network = 'UGX';
// const WEB_HOOK_3DS = 'https://rave-webhook.herokuapp.com/receivepayment';
const WEB_HOOK_3DS = 'http://192.168.43.57:5000:8000/webhook-view';
const MAX_REQUERY_COUNT = 30;
