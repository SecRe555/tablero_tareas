export default interface SupabaseJWT {
  iss: string;
  sub: string;
  aud: string;
  exp: number;
  iat: number;
  email: string;
  phone: string;
  app_metadata: {
    provider: string;
    providers: string[];
  };
  user_metadata: {
    email: string;
    email_verified: boolean;
    lastname: string;
    name: string;
    phone_verified: boolean;
    sub: string;
    username: string;
  };
  role: string;
  aal: string;
  amr: Array<{
    method: string;
    timestamp: number;
  }>;
  session_id: string;
  is_anonymous: boolean;
}
