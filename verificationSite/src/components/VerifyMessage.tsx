import { createSignal, onMount, createEffect, type JSX } from "solid-js";
import { createClient } from "@supabase/supabase-js";
import { ConfirmIcon } from "../icons/confirm";
import { ErrorIcon } from "../icons/error";
import { SendEmailIcon } from "../icons/sendEmail";

interface Props {
  supabaseUrl: string;
  supabaseAnonKey: string;
}

export default function VerifyMessage(props: Props) {
  const [content, setContent] = createSignal<JSX.Element | null>(null);

  const cleanUrl = () => {
    const url = new URL(window.location.href);
    url.search = "";
    window.history.replaceState({}, document.title, url.toString());
  };

  onMount(() => {
    const params = new URLSearchParams(window.location.search);
    const code = params.get("code");
    const error = params.get("error");
    const errorCode = params.get("error_code");
    const errorDesc = params.get("error_description");

    const supabase = createClient(props.supabaseUrl, props.supabaseAnonKey);

    if (error) {
      setContent(
        <ErrorMessage
          errorCode={errorCode}
          errorDesc={errorDesc}
          supabase={supabase}
        />
      );
      // cleanUrl();
      return;
    }
    if (code) {
      setContent(<VerifiedMessage />);
      // cleanUrl();
      return;
    }
    setContent(<WelcomeMessage />);
    cleanUrl();
  });

  return (
    <section class="w-3/4 max-w-2xl h-1/2 flex flex-col gap-7 justify-center items-center border border-black/30 rounded-2xl shadow-xl/30">
      {content()}
    </section>
  );
}

interface ErrorMessageProps {
  errorCode: string | null;
  errorDesc: string | null;
  supabase: any;
}

function ErrorMessage(props: ErrorMessageProps) {
  const [email, setEmail] = createSignal<string>();

  const resendEmail = async (event: Event) => {
    event.preventDefault();
    if (!email() || email()?.trim().length === 0) {
      alert("Ingrese un correo.");
      return;
    }
    const { error } = await props.supabase.auth.resend({
      type: "signup",
      email,
    });
    if (error) {
      alert(
        "Error al reenviar el email. Asegurese de escribir de manera correcta su correo electronico o contacte con el administrador."
      );
    } else {
      alert("Correo de verificación reenviado con éxito.");
    }
  };

  return (
    <>
      <ErrorIcon class="text-red-500 text-7xl" />
      <p>
        <strong>Error:</strong> {props.errorCode}
      </p>
      <p>
        {props.errorCode == "otp_expired"
          ? "Link invalido o expirado"
          : decodeURIComponent(props.errorDesc || "")}
      </p>
      <form on:submit={resendEmail} class="flex items-center gap-4">
        <span class="flex flex-col items-start">
          <label>Correo:</label>
          <input
            type="email"
            class="border border-black/30 rounded p-2 outline-0 focus:border-gray-700"
            on:change={(event) => setEmail(event.target.value)}
          />
        </span>

        <button
          type="submit"
          class="flex justify-center items-center gap-4 self-end p-2 rounded-lg bg-gray-500 text-white cursor-pointer hover:bg-gray-800 transition-colors"
        >
          Reenviar
          <SendEmailIcon class="text-2xl" />
        </button>
      </form>
    </>
  );
}

function VerifiedMessage() {
  return (
    <>
      <ConfirmIcon class="text-green-500 text-7xl" />
      <p class="font-bold">Su cuenta ha sido verificada exitosamente</p>
      <p class="font-bold">
        Puede cerrar esta pestaña y volver a la aplicación
      </p>
    </>
  );
}

function WelcomeMessage() {
  return (
    <>
      <h1 class="ok text-5xl">Hola</h1>
    </>
  );
}
