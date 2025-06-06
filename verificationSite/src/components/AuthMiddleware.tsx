import { createSignal, onMount, type JSX } from "solid-js";
import VerifyMessage from "./VerifyMessage";
import RecoveryPassword from "./RecoveryPassword";

interface Props {
  supabaseUrl: string;
  supabaseAnonKey: string;
}

export default function AuthMiddleware(props: Props) {
  const [view, setView] = createSignal<JSX.Element | null>(null);

  onMount(() => {
    const hash = window.location.hash;

    if (hash && hash.length > 1) {
      // Si el hash existe y no está vacío (ej. #cualquier-cosa), va a recovery
      setView(
        <RecoveryPassword
          supabaseUrl={props.supabaseUrl}
          supabaseAnonKey={props.supabaseAnonKey}
        />
      );
    } else {
      // Si no hay hash, es verificación
      setView(
        <VerifyMessage
          supabaseUrl={props.supabaseUrl}
          supabaseAnonKey={props.supabaseAnonKey}
        />
      );
    }
  });

  return <>{view()}</>;
}
